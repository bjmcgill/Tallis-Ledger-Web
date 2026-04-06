/**
 * Formats a number as a currency string (2 decimal places).
 */
export const formatCurrency = (value) => {
  if (value === null || value === undefined || value === '') return '';
  const num = Number(value);
  if (isNaN(num)) return String(value);
  return num.toFixed(2);
};
