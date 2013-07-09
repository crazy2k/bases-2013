package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.fifo.FIFOReplacementStrategy;

public class DefaultBuffer
{
	private static int BUFFER_SIZE = 500;
	private static SingleBufferPool defaultBuffer = null;
	
	protected DefaultBuffer()
	{
		
	}

	public static SingleBufferPool getDefaultBuffer()
	{
		if (defaultBuffer == null)
			defaultBuffer = new SingleBufferPool(BUFFER_SIZE, new FIFOReplacementStrategy());
		
		return defaultBuffer;
	}
}
