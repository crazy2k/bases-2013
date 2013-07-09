package ubadb.core.components.bufferManager.bufferPool.pools;

public class PoolDescriptor
{
	private String name;
	private Integer size;
	
	public PoolDescriptor()
	{		
	}
	
	public PoolDescriptor(String name, Integer size)
	{
		this.name = name;
		this.size = size;
	}
	
	public String getName()
	{
		return this.name;
	}
	
	public Integer getSize()
	{
		return this.size;
	}
}
