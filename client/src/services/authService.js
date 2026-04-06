import apiBase from './apiBase';

export const connect = async ({ user, password, database, port }) => {
  const res = await fetch(`${apiBase}/api/auth/connect`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'include',
    body: JSON.stringify({ user, password, database, port }),
  });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Connection failed.');
  return data;
};

export const logout = async () => {
  const res = await fetch(`${apiBase}/api/auth/logout`, {
    method: 'DELETE',
    credentials: 'include',
  });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Logout failed.');
  return data;
};
