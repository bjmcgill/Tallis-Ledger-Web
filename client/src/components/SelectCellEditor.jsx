import { useEffect, useRef, useState } from 'react';
import { useGridCellEditor } from 'ag-grid-react';

/**
 * Custom AG Grid v32 cell editor that renders a native <select>.
 *
 * AG Grid v32 passes these props to cell editors:
 *   initialValue  — the cell's value when editing started
 *   onValueChange — must be called whenever the value changes so the
 *                   grid's CellEditorComponentProxy stays in sync
 *   options       — [{ id, label }]  (from cellEditorParams)
 */
const SelectCellEditor = ({ initialValue, onValueChange, options }) => {
  const [value, setValue] = useState(initialValue);
  const selectRef = useRef(null);

  useEffect(() => {
    selectRef.current?.focus();
  }, []);

  // Register getValue with AG Grid's component proxy via context.
  useGridCellEditor({
    getValue: () => value,
  });

  const handleChange = (e) => {
    const newVal = Number(e.target.value);
    setValue(newVal);
    // This is the critical call — it updates proxy.value which AG Grid
    // reads when the cell stops editing.
    onValueChange(newVal);
  };

  return (
    <select
      ref={selectRef}
      value={value ?? ''}
      onChange={handleChange}
      style={{ width: '100%', height: '100%', fontSize: '13px' }}
    >
      {(options || []).map((opt) => (
        <option key={opt.id} value={opt.id}>
          {opt.label}
        </option>
      ))}
    </select>
  );
};

export default SelectCellEditor;
