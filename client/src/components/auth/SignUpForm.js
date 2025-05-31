import React, { useState } from 'axios';
import axios from 'axios';

function SignUpForm() {
  const [formData, setFormData] = useState({
    name: '',
    username: '', // Added username
    email: '',
    password: '',
    password_confirmation: '',
  });
  const [message, setMessage] = useState('');
  const [errors, setErrors] = useState([]);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setErrors([]);
    setMessage('');
    try {
      const response = await axios.post('/api/v1/signup', { user: formData });
      setMessage(response.data.message || 'Signed up successfully!');
      // console.log(response.data.user); // User data from server
      // Optionally redirect or clear form
      setFormData({ name: '', username: '', email: '', password: '', password_confirmation: '' });
    } catch (error) {
      if (error.response && error.response.data) {
        setMessage(error.response.data.message || 'Sign up failed.');
        setErrors(error.response.data.errors || ['An unknown error occurred.']);
      } else {
        setMessage('Sign up failed: Network error or server did not respond.');
        setErrors(['Network error or server did not respond.']);
      }
      console.error("Sign up error:", error);
    }
  };

  return (
    <div>
      <h2>Sign Up</h2>
      {message && <p>{message}</p>}
      {errors.length > 0 && (
        <ul>
          {errors.map((err, index) => (
            <li key={index} style={{ color: 'red' }}>{err}</li>
          ))}
        </ul>
      )}
      <form onSubmit={handleSubmit}>
        <div>
          <label>Name:</label>
          <input type="text" name="name" value={formData.name} onChange={handleChange} required />
        </div>
        <div>
          <label>Username:</label> {/* Added username field */}
          <input type="text" name="username" value={formData.username} onChange={handleChange} />
        </div>
        <div>
          <label>Email:</label>
          <input type="email" name="email" value={formData.email} onChange={handleChange} required />
        </div>
        <div>
          <label>Password:</label>
          <input type="password" name="password" value={formData.password} onChange={handleChange} required />
        </div>
        <div>
          <label>Confirm Password:</label>
          <input type="password" name="password_confirmation" value={formData.password_confirmation} onChange={handleChange} required />
        </div>
        <button type="submit">Sign Up</button>
      </form>
    </div>
  );
}

export default SignUpForm;
