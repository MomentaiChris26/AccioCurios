import React, { useState, useEffect } from 'axios';
import axios from 'axios';

function ListingsList() {
  const [listings, setListings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
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
  }, []);

  if (loading) return <p>Loading listings...</p>;
  if (error) return <p>Error: {error}</p>;
  if (listings.length === 0) return <p>No listings found.</p>;

  return (
    <div>
      <h2>Listings</h2>
      <ul>
        {listings.map(listing => (
          <li key={listing.id}>
            <h3>{listing.title}</h3>
            <p>Price: ${listing.price}</p>
            <p>Description: {listing.description}</p>
            {listing.category && <p>Category: {listing.category.name}</p>}
            {listing.condition && <p>Condition: {listing.condition.name}</p>}
            {listing.user && <p>Seller: {listing.user.name || listing.user.email}</p>}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default ListingsList;
