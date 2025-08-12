

export function attachSocketIO(io) {
  return (req, res, next) => {
    req.io = io;
    next();
  };
}