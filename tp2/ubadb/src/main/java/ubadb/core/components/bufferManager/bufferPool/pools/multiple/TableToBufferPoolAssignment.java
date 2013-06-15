package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;

public class TableToBufferPoolAssignment implements BufferPoolAssignment 
{
	public TableId tableId;
	public BufferPool bufferPool;

	public TableToBufferPoolAssignment(TableId tableId, BufferPool bufferPool) 
	{
		this.tableId = tableId;
		this.bufferPool = bufferPool;
	}

	@Override
	public boolean canHandle(PageId pageId) 
	{
		return this.tableId.equals(pageId.getTableId());
	}

	@Override
	public BufferPool getBufferPool() 
	{
		return bufferPool;
	}
}