package ubadb.core.components.catalogManager;

import ubadb.core.common.TableId;

public class TableDescriptor
{
	private TableId tableId;
	private String tableName;
	private String tablePath;

	public TableDescriptor()
	{		
	}
	
	public TableDescriptor(TableId tableId, String tableName, String tablePath)
	{
		this.tableId = tableId;
		this.tableName = tableName;
		this.tablePath = tablePath;
	}

	public TableId getTableId()
	{
		return tableId;
	}

	public String getTableName()
	{
		return tableName;
	}

	public String getTablePath()
	{
		return tablePath;
	}
	
	@Override
	public boolean equals(Object obj) 
	{
		if (this == obj)
			return true;
		
		if (obj == null)
			return false;
		
		if (getClass() != obj.getClass())
			return false;
		
		TableDescriptor other = (TableDescriptor) obj;
		
		boolean res = this.tableId.equals(other.tableId);
		res = res && this.tableName.equals(other.tableName);
		res = res && this.tablePath.equals(other.tablePath);
		
		return res;
	}
}
