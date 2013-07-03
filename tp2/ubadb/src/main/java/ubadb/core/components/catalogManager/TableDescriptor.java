package ubadb.core.components.catalogManager;

import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.pools.multiple.DefaultBuffer;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;

public class TableDescriptor
{
	private TableId tableId;
	private String tableName;
	private String tablePath;
	private SingleBufferPool tableBuffer;

	public TableDescriptor()
	{		
	}
	
	
	
	public TableDescriptor(TableId tableId, String tableName, String tablePath, SingleBufferPool tableBuffer)
	{
		this.tableId = tableId;
		this.tableName = tableName;
		this.tablePath = tablePath;
		this.tableBuffer = tableBuffer;
	}
	
	public TableDescriptor(TableId tableId, String tableName, String tablePath)
	{
		this(tableId, tableName, tablePath, DefaultBuffer.getDefaultBuffer());
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
	
	public SingleBufferPool getTableBuffer()
	{
		return tableBuffer;
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
		res = res && this.tableBuffer.equals(other.tableBuffer);
		
		return res;
	}
}
