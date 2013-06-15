package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;

/**
 * Buffer pool that will cache the pages of a given table.
 */
public class TablePool 
{	
	private final String tableName;	
	private final int bufferPercentage;	
	private final PageReplacementStrategy replacementStrategy;
	
	/**
	 * @param tableName name of the corresponding table
	 * @param bufferPercentage percentage of the total buffer size assigned to this pool
	 * @param replacementStrategy page replacement strategy for this pool
	 */
	public TablePool(String tableName, int bufferPercentage,
			PageReplacementStrategy replacementStrategy) 
	{
		this.tableName = tableName;
		this.bufferPercentage = bufferPercentage;
		this.replacementStrategy = replacementStrategy;
	}

	public String getTableName() 
	{
		return tableName;
	}

	public int getBufferPercentage() 
	{
		return bufferPercentage;
	}

	public PageReplacementStrategy getReplacementStrategy() 
	{
		return replacementStrategy;
	}

}