const requireAuth = (req, res, next) => {
  if (!req.session || !req.session.dbCredentials) {
    return res.status(401).json({ message: 'Not authenticated. Please connect to the database first.' });
  }
  next();
};

module.exports = requireAuth;
