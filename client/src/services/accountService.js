import apiBase from './apiBase';

export const fetchAccounts = async () => {
  const res = await fetch(`${apiBase}/api/accounts`, { credentials: 'include' });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Failed to fetch accounts.');
  return data;
};
