import apiBase from './apiBase';

export const fetchLedger = async (type, id) => {
  const res = await fetch(`${apiBase}/api/ledger?type=${type}&id=${id}`, { credentials: 'include' });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Failed to fetch ledger.');
  return data;
};
