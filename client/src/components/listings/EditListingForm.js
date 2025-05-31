import React, { useState, useEffect } from 'axios';
import axios from 'axios';
import { useNavigate, useParams } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';

function EditListingForm() {
  const { id: listingId } = useParams();
  const { token } = useAuth(); // Ensure user is authenticated
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    price: '',
    category_id: '',
    condition_id: '',
    sold: false,
    image: null,
  });
  const [currentImageUrl, setCurrentImageUrl] = useState(null);
  const [categories, setCategories] = useState([]);
  const [conditions, setConditions] = useState([]);
  const [message, setMessage] = useState('');
  const [errors, setErrors] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    axios.get(`/api/v1/listings/${listingId}`)
      .then(res => {
        const listing = res.data;
        setFormData({
          title: listing.title || '',
          description: listing.description || '',
          price: listing.price || '',
          category_id: listing.category?.id || '', // Use optional chaining
          condition_id: listing.condition?.id || '', // Use optional chaining
          sold: listing.sold || false,
          image: null,
        });

        // Attempt to construct or get image URL
        // This part depends heavily on how Rails serializes the ActiveStorage attachment
        if (listing.image_url) { // If image_url is directly provided by serializer
            setCurrentImageUrl(listing.image_url);
        } else if (listing.image && listing.image.url) { // Common if using default ActiveStorage serialization with url_helpers
            setCurrentImageUrl(listing.image.url);
        }
        // Add more sophisticated ways to get image URL if needed, e.g. using Rails.application.routes.url_helpers.rails_blob_path

        setLoading(false);
      })
      .catch(err => {
        console.error("Failed to fetch listing", err);
        setMessage("Failed to load listing data. You may not be authorized to edit this listing or it may not exist.");
        setErrors([err.message || "Error loading data."]);
        setLoading(false);
      });

    axios.get('/api/v1/categories')
      .then(res => setCategories(res.data))
      .catch(err => console.error("Failed to fetch categories", err));

    axios.get('/api/v1/conditions')
      .then(res => setConditions(res.data))
      .catch(err => console.error("Failed to fetch conditions", err));
  }, [listingId]);

  const handleChange = (e) => {
    const { name, value, type, checked, files } = e.target;
    if (name === 'image') {
      setFormData({ ...formData, image: files[0] });
    } else if (type === 'checkbox') {
      setFormData({ ...formData, [name]: checked });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!token) {
      setMessage("You must be logged in to edit a listing.");
      setErrors([]);
      return;
    }
    setErrors([]);
    setMessage('');

    const submissionData = new FormData();
    Object.keys(formData).forEach(key => {
      if (key === 'image' && !formData.image) { // Don't append image if it wasn't changed
        return;
      }
      submissionData.append(`listing[${key}]`, formData[key]);
    });

    try {
      const response = await axios.patch(`/api/v1/listings/${listingId}`, submissionData, {
        headers: { 'Content-Type': 'multipart/form-data' },
      });
      setMessage('Listing updated successfully!');
      if (response.data && response.data.id) {
        navigate(`/listings/${response.data.id}`);
      } else {
        navigate('/listings');
      }
    } catch (error) {
      if (error.response && error.response.data) {
        setMessage(error.response.data.message || 'Failed to update listing.');
        setErrors(error.response.data.errors || ['An unknown error occurred.']);
      } else {
        setMessage('Failed to update listing: Network error or server unresponsive.');
        setErrors([error.message || 'Network error or server unresponsive.']);
      }
      console.error("Update listing error:", error);
    }
  };

  if (loading) return <p>Loading listing data...</p>;
  if (!loading && errors.length > 0 && !formData.title) { // If loading finished but form data is empty and errors occurred
    return <div><p style={{color: 'red'}}>{message}</p> <ul>{errors.map((e,i) => <li key={i}>{e}</li>)}</ul></div>;
  }


  return (
    <div>
      <h2>Edit Listing</h2>
      {currentImageUrl && !formData.image && (
        <div>
          <p>Current Image:</p>
          <img src={currentImageUrl} alt="Current Listing" style={{maxWidth: '200px', maxHeight: '200px', marginBottom: '10px'}} />
        </div>
      )}
      {message && <p style={{ color: errors.length > 0 ? 'red' : 'green' }}>{message}</p>}
      {errors.length > 0 && ( <ul style={{ color: 'red' }}> {errors.map((err, index) => ( <li key={index}>{err}</li> ))} </ul> )}
      <form onSubmit={handleSubmit}>
        <div><label>Title:</label><input type="text" name="title" value={formData.title} onChange={handleChange} required /></div>
        <div><label>Description:</label><textarea name="description" value={formData.description} onChange={handleChange} required /></div>
        <div><label>Price:</label><input type="number" name="price" value={formData.price} onChange={handleChange} required step="0.01" /></div>
        <div>
          <label>Category:</label>
          <select name="category_id" value={formData.category_id} onChange={handleChange} required>
            <option value="">Select Category</option>
            {categories.map(cat => <option key={cat.id} value={cat.id}>{cat.name}</option>)}
          </select>
        </div>
        <div>
          <label>Condition:</label>
          <select name="condition_id" value={formData.condition_id} onChange={handleChange} required>
            <option value="">Select Condition</option>
            {conditions.map(cond => <option key={cond.id} value={cond.id}>{cond.name}</option>)}
          </select>
        </div>
        <div><label>New Image (optional):</label><input type="file" name="image" onChange={handleChange} /></div>
        <div><label>Sold:</label><input type="checkbox" name="sold" checked={formData.sold} onChange={handleChange} /></div>
        <button type="submit">Update Listing</button>
      </form>
    </div>
  );
}
export default EditListingForm;
