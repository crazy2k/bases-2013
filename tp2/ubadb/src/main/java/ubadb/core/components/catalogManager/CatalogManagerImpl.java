package ubadb.core.components.catalogManager;

//import java.io.FileNotFoundException;
import java.util.List;

import com.thoughtworks.xstream.XStream;

import ubadb.core.common.TableId;

import ubadb.core.components.catalogManager.Catalog;
import ubadb.core.components.catalogManager.CatalogManagerException;
import ubadb.core.components.catalogManager.TableDescriptor;

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
		
		String filename = filePathPrefix + catalogFilePath;
		XStream xstream = new XStream();
		XmlUtil xml = new XstreamXmlUtil(xstream);
		List<TableDescriptor> l;
		
		try 
		{
			l = (List<TableDescriptor>) xml.fromXml(filename);
			catalog = new Catalog(l);
		} 
		catch (XmlUtilException e) 
		{			
			e.printStackTrace();
		}
	}

	@Override
	public TableDescriptor getTableDescriptorByTableId(TableId tableId)
	{
		return catalog.getTableDescriptorByTableId(tableId);
	}
}
