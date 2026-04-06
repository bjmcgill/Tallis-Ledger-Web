import apiBase from './apiBase';

export const fetchFunds = async () => {
  const res = await fetch(`${apiBase}/api/funds`, { credentials: 'include' });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Failed to fetch funds.');
  return data;
};
