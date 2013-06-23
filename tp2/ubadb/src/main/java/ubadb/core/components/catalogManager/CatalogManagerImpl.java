package ubadb.core.components.catalogManager;


import java.io.FileInputStream;
import java.io.FileNotFoundException;

import com.thoughtworks.xstream.XStream;

import ubadb.core.common.TableId;

public class CatalogManagerImpl implements CatalogManager
{
	private String catalogFilePath;
	private String filePathPrefix;
	private Catalog catalog;
	
	public CatalogManagerImpl(String catalogFilePath, String filePathPrefix) 
	{
		this.catalogFilePath = catalogFilePath;
		this.filePathPrefix = filePathPrefix;
	}

	@Override
	public void loadCatalog() throws CatalogManagerException
	{
		//TODO Completar levantando desde un XML el catálogo
		XStream xstream = new XStream();			
		String filename = filePathPrefix + catalogFilePath;
		
		try 
		{
			catalog = (Catalog) xstream.fromXML(new FileInputStream(filename));
		} 
		catch (FileNotFoundException e) 
		{
			e.printStackTrace();
		}
		
	}

	public Catalog catalog()
	{
		return catalog;
	}
	
	@Override
	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		return catalog.getTableDescriptorByTableId(tableId);
	}
}
