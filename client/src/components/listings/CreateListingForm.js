import React, { useState, useEffect } from 'axios';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext'; // To ensure user is logged in

function CreateListingForm() {
  const { user, token } = useAuth(); // Use token to ensure user is authenticated client-side too
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    price: '',
    category_id: '',
    condition_id: '',
    image: null,
  });
  const [categories, setCategories] = useState([]);
  const [conditions, setConditions] = useState([]);
  const [message, setMessage] = useState('');
  const [errors, setErrors] = useState([]);

  // Fetch categories and conditions for dropdowns
  useEffect(() => {
    axios.get('/api/v1/categories')
      .then(res => setCategories(res.data))
      .catch(err => console.error("Failed to fetch categories", err));

    axios.get('/api/v1/conditions')
      .then(res => setConditions(res.data))
      .catch(err => console.error("Failed to fetch conditions", err));
  }, []);

  const handleChange = (e) => {
    if (e.target.name === 'image') {
      setFormData({ ...formData, image: e.target.files[0] });
    } else {
      setFormData({ ...formData, [e.target.name]: e.target.value });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!token) {
      setMessage("You must be logged in to create a listing.");
      setErrors([]); // Clear previous errors
      return;
    }
    setErrors([]);
    setMessage('');

    const submissionData = new FormData();
    Object.keys(formData).forEach(key => {
      submissionData.append(`listing[${key}]`, formData[key]);
    });

    try {
      const response = await axios.post('/api/v1/listings', submissionData, {
        headers: {
          'Content-Type': 'multipart/form-data',
          // Authorization header is already set by AuthContext's axios defaults
        },
      });
      setMessage('Listing created successfully!');
      // console.log(response.data);
      // Assuming the response data includes the new listing's id
      // And that your ListingsController's create action returns the full listing object
      if (response.data && response.data.id) {
        navigate(`/listings/${response.data.id}`);
      } else {
        // Fallback if ID is not in response, or navigate to a general listings page
        navigate('/listings');
      }
    } catch (error) {
      if (error.response && error.response.data) {
        setMessage(error.response.data.message || 'Failed to create listing.');
        setErrors(error.response.data.errors || ['An unknown error occurred.']);
      } else {
        setMessage('Failed to create listing: Network error or server unresponsive.');
        setErrors([error.message || 'Network error or server unresponsive.']);
      }
      console.error("Create listing error:", error);
    }
  };

  return (
    <div>
      <h2>Create New Listing</h2>
      {message && <p style={{ color: errors.length > 0 ? 'red' : 'green' }}>{message}</p>}
      {errors.length > 0 && (
        <ul style={{ color: 'red' }}>
          {errors.map((err, index) => (
            <li key={index}>{err}</li>
          ))}
        </ul>
      )}
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
        <div><label>Image:</label><input type="file" name="image" onChange={handleChange} /></div>
        <button type="submit">Create Listing</button>
      </form>
    </div>
  );
}
export default CreateListingForm;
