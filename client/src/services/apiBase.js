const apiBase = import.meta.env.MODE === 'production' ? '/accounts' : '';
export default apiBase;