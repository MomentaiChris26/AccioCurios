import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import ListingsList from './components/ListingsList';
import CategoriesList from './components/CategoriesList';
import './App.css';

function Home() {
  return (
    <div>
      <h1>Welcome to the Marketplace</h1>
      <p>Browse our listings and categories.</p>
    </div>
  );
}

function App() {
  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li><Link to="/">Home</Link></li>
            <li><Link to="/listings">Listings</Link></li>
            <li><Link to="/categories">Categories</Link></li>
          </ul>
        </nav>
        <hr />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/listings" element={<ListingsList />} />
          <Route path="/categories" element={<CategoriesList />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
