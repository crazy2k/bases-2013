package ubadb.core.components.catalogManager;

import java.util.List;

import ubadb.core.common.TableId;

/**
 * Serializable class that represents the catalog
 * 
 */
public class Catalog
{
	private List<TableDescriptor> tableDescriptors;
//	private Integer keepBufferSize;
//	private Integer recycleBufferSize;

	public Catalog()
	{		
	}
	
	public Catalog(List<TableDescriptor> tableDescriptors)
	{
		this.tableDescriptors = tableDescriptors;
	}
	
	public List<TableDescriptor> getTableDescriptors()
	{
		return tableDescriptors;
	}
	
	private boolean idMatch(TableDescriptor t, TableId tableId)
	{
		return t.getTableId().equals(tableId);
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
