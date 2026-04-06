import apiBase from './apiBase';

export const fetchTransaction = async (id) => {
  const res = await fetch(`${apiBase}/api/transactions/${id}`, { credentials: 'include' });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Failed to fetch transaction.');
  return data;
};

export const createTransaction = async (payload) => {
  const res = await fetch(`${apiBase}/api/transactions`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'include',
    body: JSON.stringify(payload),
  });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Failed to create transaction.');
  return data;
};

export const updateTransaction = async (id, payload) => {
  const res = await fetch(`${apiBase}/api/transactions/${id}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    credentials: 'include',
    body: JSON.stringify(payload),
  });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Failed to update transaction.');
  return data;
};

export const deleteTransaction = async (id) => {
  const res = await fetch(`${apiBase}/api/transactions/${id}`, {
    method: 'DELETE',
    credentials: 'include',
  });
  const data = await res.json();
  if (!res.ok) throw new Error(data.message || 'Failed to delete transaction.');
  return data;
};