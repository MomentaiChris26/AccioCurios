import React, { useState, useEffect } from 'axios';
import axios from 'axios';
import { Link, useNavigate } from 'react-router-dom'; // Added Link and useNavigate
import { useAuth } from '../../context/AuthContext'; // Added useAuth

function ListingsList() {
  const [listings, setListings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const { user, token } = useAuth(); // Get current user and token
  const navigate = useNavigate();

  const fetchListings = () => {
    axios.get('/api/v1/listings')
      .then(response => {
        setListings(response.data);
        setLoading(false);
      })
      .catch(error => {
        console.error("Error fetching listings:", error);
        setError(error.message || 'Failed to fetch listings');
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchListings();
  }, []);

  const handleDelete = async (listingId) => {
    if (!token) {
      alert("You must be logged in to delete listings.");
      return;
    }
    if (window.confirm("Are you sure you want to delete this listing?")) {
      try {
        await axios.delete(`/api/v1/listings/${listingId}`);
        // Refresh listings after delete
        fetchListings();
        alert("Listing deleted successfully.");
      } catch (err) {
        console.error("Error deleting listing:", err);
        alert("Failed to delete listing: " + (err.response?.data?.error || err.message));
      }
    }
  };

  if (loading) return <p>Loading listings...</p>;
  if (error) return <p>Error: {error}</p>;
  if (listings.length === 0) return <p>No listings found.</p>;

  return (
    <div>
      <h2>Listings</h2>
      <ul>
        {listings.map(listing => {
          // Image URL is directly available as listing.image_url from the controller
          const imageUrl = listing.image_url;
          return (
            <li key={listing.id} style={{ marginBottom: '20px', borderBottom: '1px solid #eee', paddingBottom: '10px' }}>
              <h3><Link to={`/listings/${listing.id}`}>{listing.title}</Link></h3>
              {imageUrl && <img src={imageUrl} alt={listing.title} style={{maxWidth: '150px', maxHeight: '150px'}} />}
              <p>Price: ${listing.price}</p>
              <p>Description: {listing.description.substring(0,100)}{listing.description.length > 100 ? '...' : ''}</p>
              {listing.category && <p>Category: {listing.category.name}</p>}
              {listing.condition && <p>Condition: {listing.condition.name}</p>}
              {listing.user && <p>Seller: {listing.user.name || listing.user.email}</p>}
              <p>Sold: {listing.sold ? 'Yes' : 'No'}</p>
              {user && listing.user && user.id === listing.user.id && (
                <div style={{marginTop: '5px'}}>
                  <Link to={`/listings/${listing.id}/edit`} style={{marginRight: '10px'}}>Edit</Link>
                  <button onClick={() => handleDelete(listing.id)}>Delete</button>
                </div>
              )}
            </li>
          );
        })}
      </ul>
    </div>
  );
}

export default ListingsList;
