import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import ListingsList from './components/ListingsList';
import CategoriesList from './components/CategoriesList';
import './App.css';
import LoginForm from './components/auth/LoginForm';
import SignUpForm from './components/auth/SignUpForm';
import ProtectedRoute from './components/ProtectedRoute';
import { useAuth } from './context/AuthContext'; // Import useAuth
import CreateListingForm from './components/listings/CreateListingForm';
import EditListingForm from './components/listings/EditListingForm';
import ListingShow from './components/listings/ListingShow';

function Home() {
  return (
    <div>
      <h1>Welcome to the Marketplace</h1>
      <p>Browse our listings and categories.</p>
    </div>
  );
}

// Example Dashboard component (can be inline or a new file)
function Dashboard() {
  const { user } = useAuth();
  return (
    <div>
      <h2>Dashboard</h2>
      <p>Welcome, {user?.name || user?.email}!</p>
      <p>This is a protected area.</p>
    </div>
  );
}

function App() {
  const auth = useAuth(); // Get auth context

  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li><Link to="/">Home</Link></li>
            <li><Link to="/listings">Listings</Link></li>
            <li><Link to="/categories">Categories</Link></li>
            {auth.isAuthenticated && <li><Link to="/listings/new">Create Listing</Link></li>}
            {!auth.isAuthenticated && <li><Link to="/login">Login</Link></li>}
            {!auth.isAuthenticated && <li><Link to="/signup">Sign Up</Link></li>}
            {auth.isAuthenticated && <li><Link to="/dashboard">Dashboard</Link></li>}
            {auth.isAuthenticated && (
              <li>
                <button onClick={() => auth.logout()}>Logout</button>
              </li>
            )}
          </ul>
        </nav>
        <hr />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/listings" element={<ListingsList />} />
          <Route path="/categories" element={<CategoriesList />} />
          <Route path="/login" element={<LoginForm />} />
          <Route path="/signup" element={<SignUpForm />} />
          <Route path="/listings/:id" element={<ListingShow />} />
          <Route element={<ProtectedRoute />}>
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/listings/new" element={<CreateListingForm />} />
            <Route path="/listings/:id/edit" element={<EditListingForm />} />
            {/* Add other protected routes here */}
          </Route>
        </Routes>
      </div>
    </Router>
  );
}

export default App;
