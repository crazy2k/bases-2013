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

	public Catalog(List<TableDescriptor> tableDescriptors) 
	{
		super();
		this.tableDescriptors = tableDescriptors;
	}

	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		//TODO Completar
		/* Recorrer la lista y obtener el que buscamos. */
		
		TableDescriptor result = null;
		
		for (TableDescriptor t : tableDescriptors)
		{
			if (t.getTableId() == tableId)
			{
				result = t;
				break;
			}
		}
		
		return result;
	}
}
