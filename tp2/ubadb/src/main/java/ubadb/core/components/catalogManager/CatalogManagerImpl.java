package ubadb.core.components.catalogManager;

import java.io.FileNotFoundException;

import ubadb.core.common.TableId;
import ubadb.core.util.xml.XmlUtil;
import ubadb.core.util.xml.XmlUtilException;
import ubadb.core.util.xml.XstreamXmlUtil;

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

		/*
		try 
		{	
			String filename = filePathPrefix + catalogFilePath;
			//this.catalog = fromXml(filename);
			//Object o = fromXml(filename);
		}
		catch (XmlUtilException e) 
		{			
			
		}
		*/
		
	}

	@Override
	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		return catalog.getTableDescriptorByTableId(tableId);
	}
}
