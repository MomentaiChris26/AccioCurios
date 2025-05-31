import React, { useState, useEffect } from 'axios';
import { useParams, Link, useNavigate } from 'react-router-dom'; // Added useNavigate
import axios from 'axios';
import { useAuth } from '../../context/AuthContext';


function ListingShow() {
  const { id } = useParams();
  const [listing, setListing] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const { user } = useAuth();
  const navigate = useNavigate(); // For navigation after delete

  useEffect(() => {
    axios.get(`/api/v1/listings/${id}`)
      .then(response => {
        setListing(response.data);
        setLoading(false);
      })
      .catch(err => {
        console.error("Error fetching listing:", err);
        setError(err.message || `Failed to fetch listing ${id}`);
        setLoading(false);
      });
  }, [id]);

  const handleDelete = async () => {
    if (window.confirm("Are you sure you want to delete this listing?")) {
      try {
        await axios.delete(`/api/v1/listings/${id}`);
        alert("Listing deleted successfully.");
        navigate('/listings');
      } catch (err) {
        console.error("Error deleting listing:", err);
        alert("Failed to delete listing: " + (err.response?.data?.error || err.message));
      }
    }
  };


  if (loading) return <p>Loading listing...</p>;
  if (error) return <p>Error: {error}</p>;
  if (!listing) return <p>Listing not found.</p>;

  // Image URL is directly available as listing.image_url from the controller
  const imageUrl = listing.image_url;

  return (
    <div>
      <h2>{listing.title}</h2>
      {imageUrl && <img src={imageUrl} alt={listing.title} style={{maxWidth: '300px', marginBottom: '15px'}} />}
      <p><strong>Price:</strong> ${listing.price}</p>
      <p><strong>Description:</strong> {listing.description}</p>
      {listing.category && <p><strong>Category:</strong> {listing.category.name}</p>}
      {listing.condition && <p><strong>Condition:</strong> {listing.condition.name}</p>}
      {listing.user && <p><strong>Seller:</strong> {listing.user.name || listing.user.email}</p>}
      <p><strong>Sold:</strong> {listing.sold ? 'Yes' : 'No'}</p>

      {user && listing.user && user.id === listing.user.id && (
        <div style={{marginTop: '15px'}}>
          <Link to={`/listings/${listing.id}/edit`} style={{textDecoration: 'none', padding: '8px 12px', backgroundColor: '#007bff', color: 'white', borderRadius: '4px', marginRight: '10px'}}>Edit Listing</Link>
          <button onClick={handleDelete} style={{padding: '8px 12px', backgroundColor: '#dc3545', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer'}}>Delete Listing</button>
        </div>
      )}
      <div style={{marginTop: '15px'}}>
        <Link to="/listings">Back to Listings</Link>
      </div>
    </div>
  );
}

export default ListingShow;
