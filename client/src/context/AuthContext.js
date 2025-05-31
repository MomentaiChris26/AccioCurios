import React, { createContext, useState, useContext, useEffect } from 'axios';
import axios from 'axios';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [token, setToken] = useState(localStorage.getItem('token')); // Load token from localStorage
  const [loading, setLoading] = useState(true); // To check initial auth status

  useEffect(() => {
    const storedToken = localStorage.getItem('token');
    // No need to parse storedUser here anymore, /me will provide fresh data

    if (storedToken) {
      axios.get('/api/v1/me', {
        headers: {
          'Authorization': `Bearer ${storedToken}`
        }
      })
      .then(response => {
        setUser(response.data); // Set user with fresh data from API
        setToken(storedToken); // Token is still valid
        axios.defaults.headers.common['Authorization'] = `Bearer ${storedToken}`;
      })
      .catch(error => {
        console.error("Token validation failed or /me call failed:", error);
        localStorage.removeItem('token');
        localStorage.removeItem('user'); // Clear any stale user data
        setToken(null);
        setUser(null);
        delete axios.defaults.headers.common['Authorization'];
        // Optionally, redirect to login if the error indicates an auth failure (e.g., 401)
        // This might require access to navigate function or a global event.
        // For now, clearing state will make ProtectedRoute redirect.
      })
      .finally(() => {
        setLoading(false);
      });
    } else {
      setLoading(false); // No token, not logged in
    }
  }, []); // Empty dependency array means this runs once on mount

  const login = (newToken, userData) => {
    localStorage.setItem('token', newToken);
    // Storing user from login response is fine for immediate UI update,
    // but /me call on reload will be the source of truth.
    localStorage.setItem('user', JSON.stringify(userData));
    setToken(newToken);
    setUser(userData);
    axios.defaults.headers.common['Authorization'] = `Bearer ${newToken}`;
  };

  const logout = async () => { // Make logout async if you want to await API call
    const storedToken = localStorage.getItem('token');
    if (storedToken) {
        try {
            // Optional: Inform backend of logout.
            // await axios.delete('/api/v1/logout'); // Header already set
        } catch (error) {
            console.error("Logout API call failed", error);
            // Still proceed with client-side logout
        }
    }

    localStorage.removeItem('token');
    localStorage.removeItem('user');
    setToken(null);
    setUser(null);
    delete axios.defaults.headers.common['Authorization'];
  };

  return (
    <AuthContext.Provider value={{ user, token, login, logout, loading, isAuthenticated: !!token && !!user }}>
      {!loading && children} {/* Render children only after loading is complete */}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
