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
	
	boolean idMatch(TableDescriptor t, TableId tableId)
	{
		return t.getTableId().isEqual(tableId);
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
}
