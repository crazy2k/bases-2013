package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;

/**
 * MultipleBufferPool that defines a pool per table.
 */
public class PerTableMultipleBufferPool extends MultipleBufferPool 
{
	private final int totalBufferSize;
	
	public PerTableMultipleBufferPool(int totalBufferSize, TablePool[] tablePools) 
	{
		this.totalBufferSize = totalBufferSize;
		
		for(TablePool tablePool : tablePools) 
		{
			TableId tableId = new TableId(tablePool.getTableName());			
			int poolSize = (int) (this.totalBufferSize * (tablePool.getBufferPercentage() / 100.0));
			
			BufferPool bufferPool = new SingleBufferPool(poolSize, tablePool.getReplacementStrategy());			
			assignPool(new TableToBufferPoolAssignment(tableId, bufferPool));
		}
	}
}