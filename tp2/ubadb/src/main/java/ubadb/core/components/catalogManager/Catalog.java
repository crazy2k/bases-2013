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

	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		//TODO Completar
		/* Recorrer la lista y obtener el que buscamos. */
		
		TableDescriptor result = null;
		
		for (int i = 0; i < tableDescriptors.size(); i++)
		{
			if (tableDescriptors.get(i).getTableId() == tableId)
			{
				result = tableDescriptors.get(i);
				break;
			}
		}
		
		return result;
	}
}
