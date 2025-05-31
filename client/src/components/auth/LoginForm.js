import React, { useState } from 'react';
import axios from 'axios';
import { useAuth } from '../../context/AuthContext';

function LoginForm() {
  const auth = useAuth();
  const [formData, setFormData] = useState({
    email: '',
    password: '',
  });
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setMessage('');
    try {
      // Note: Devise expects params nested under 'user' for session creation by default
      // but our Api::V1::SessionsController is set up to directly use auth_options
      // which pulls params from the root. So, we send formData directly.
      const response = await axios.post('/api/v1/login', formData );
      setMessage(response.data.message || 'Logged in successfully!');
      // console.log('Token:', response.data.token);
      // console.log('User:', response.data.user);

      // Here you would typically save the token and user info
      // using a context or state management solution (e.g., localStorage and AuthContext)
      auth.login(response.data.token, response.data.user);


      // Optionally redirect or update UI
      setFormData({ email: '', password: '' });
    } catch (error) {
      if (error.response && error.response.data) {
        setError(error.response.data.message || 'Login failed. Please check your credentials.');
      } else {
        setError('Login failed: Network error or server did not respond.');
      }
      console.error("Login error:", error);
    }
  };

  return (
    <div>
      <h2>Login</h2>
      {message && <p>{message}</p>}
      {error && <p style={{ color: 'red' }}>{error}</p>}
      <form onSubmit={handleSubmit}>
        <div>
          <label>Email:</label>
          <input type="email" name="email" value={formData.email} onChange={handleChange} required />
        </div>
        <div>
          <label>Password:</label>
          <input type="password" name="password" value={formData.password} onChange={handleChange} required />
        </div>
        <button type="submit">Login</button>
      </form>
    </div>
  );
}

export default LoginForm;
