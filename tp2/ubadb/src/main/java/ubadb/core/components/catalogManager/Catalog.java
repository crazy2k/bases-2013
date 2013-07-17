package ubadb.core.components.catalogManager;

import java.util.List;

import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.pools.PoolDescriptor;

/**
 * Serializable class that represents the catalog
 * 
 */
public class Catalog
{
	/*private Map<String, SingleBufferPool> bufferPools;*/
	private List<PoolDescriptor> poolDescriptors;
	private List<TableDescriptor> tableDescriptors;	

	public Catalog()
	{		
	}
	
	public Catalog(List<TableDescriptor> tableDescriptors, List<PoolDescriptor> poolDescriptors)
	{
		this.tableDescriptors = tableDescriptors;
		this.poolDescriptors = poolDescriptors;
	}
	
	public List<TableDescriptor> getTableDescriptors()
	{
		return tableDescriptors;
	}
	
	public List<PoolDescriptor> getPoolDescriptors() 
	{
		return poolDescriptors;
	}	
	
	public String listPoolDescriptors()
	{
		String res = "";
		
		for (PoolDescriptor p : poolDescriptors)
		{
			res += p.getName();
			res += " : " + p.getSize() + " ";
		}
		
		return res;
	}
	
	private boolean idMatch(TableDescriptor t, TableId tableId)
	{
		return t.getTableId().equals(tableId);
	}
	
	public Integer getSizeOfPool(String name) throws Exception 
	{
		for (PoolDescriptor p:poolDescriptors)
		{
			if (p.getName() == name)
			{
				return p.getSize();
			}
		}
		
		throw new Exception("Name does not exists");
	}
	
	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{		
		/* Recorrer la lista y obtener el que buscamos. */
		
		TableDescriptor result = null;		
		
		for (TableDescriptor t : tableDescriptors)
		{
			if (idMatch(t, tableId))
			{
				result = t;
				break;
			}
		}
		
		return result;
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
		
		Catalog other = (Catalog) obj;		
		
		boolean res = tableDescriptors.containsAll(other.tableDescriptors);
		res = res && other.tableDescriptors.containsAll(tableDescriptors);
		
		return res;
	}
}
