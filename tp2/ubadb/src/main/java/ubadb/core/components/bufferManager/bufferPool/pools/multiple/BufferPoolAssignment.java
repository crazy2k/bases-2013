package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import ubadb.core.common.PageId;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;

public interface BufferPoolAssignment 
{
	public abstract boolean canHandle(PageId pageId);
	public abstract BufferPool getBufferPool();
}
