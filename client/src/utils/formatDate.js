/**
 * Returns today's date as a YYYY-MM-DD string (local time).
 */
export const todayString = () => {
  const d = new Date();
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
};

/** Converts YYYY-MM-DD → DD/MM/YYYY. Returns value unchanged if not in expected format. */
export const ymdToDmy = (ymd) => {
  if (!ymd) return '';
  const parts = String(ymd).split('-');
  if (parts.length !== 3) return ymd;
  return `${parts[2]}/${parts[1]}/${parts[0]}`;
};

/** Converts DD/MM/YYYY → YYYY-MM-DD. Returns value unchanged if not in expected format. */
export const dmyToYmd = (dmy) => {
  if (!dmy) return '';
  const parts = String(dmy).split('/');
  if (parts.length !== 3) return dmy;
  return `${parts[2]}-${parts[1]}-${parts[0]}`;
};

/** Returns today's date as DD/MM/YYYY. */
export const todayDmy = () => ymdToDmy(todayString());

/**
 * Formats a Date or date string as YYYY-MM-DD.
 */
export const formatDate = (value) => {
  if (!value) return '';
  const s = String(value);
  // Already in YYYY-MM-DD format
  if (/^\d{4}-\d{2}-\d{2}/.test(s)) return s.slice(0, 10);
  const d = new Date(value);
  if (isNaN(d)) return String(value);
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
};
