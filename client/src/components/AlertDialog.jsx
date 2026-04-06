import './AlertDialog.css';

const AlertDialog = ({ message, onClose }) => {
  if (!message) return null;

  return (
    <div className="dialog-overlay">
      <div className="dialog-box">
        <p className="dialog-message">{message}</p>
        <div className="dialog-actions">
          <button onClick={onClose}>OK</button>
        </div>
      </div>
    </div>
  );
};

export default AlertDialog;
