package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import ubadb.core.common.PageId;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;;

public class DefaultBufferPoolAssignment implements BufferPoolAssignment 
{
	private SingleBufferPool defaultBufferPool;

	public DefaultBufferPoolAssignment(SingleBufferPool defaultBufferPool) 
	{
		//super();
		this.defaultBufferPool = defaultBufferPool;
	}

	@Override
	public boolean canHandle(PageId pageId) 
	{
		return true;
	}

	@Override
	public BufferPool getBufferPool() 
	{
		return defaultBufferPool;
	}

}