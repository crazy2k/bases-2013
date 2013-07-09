package ubadb.core.components.catalogManager;

import static org.junit.Assert.assertTrue;

import java.io.FileOutputStream;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.testDoubles.SampleCatalog;

import com.thoughtworks.xstream.XStream;

public class CatalogManagerImplTest 
{	
	private Catalog catalog;	
	
	@Before
	public void setUp()
	{	
		catalog = (new SampleCatalog().getCatalog());		 
	}
	
	@Test
	public void testLoadCatalog() throws Exception
	{
		XStream xstream = new XStream();			
		String filename = "catalogTestFile.xml";
		xstream.toXML(catalog, new FileOutputStream(filename));		
		
		CatalogManager catalogManager = new CatalogManagerImpl("", filename);		
		catalogManager.loadCatalog();		
		
		assertTrue(catalogManager.catalog().equals(catalog));		
	}
	
	@Test
	public void testLoadCatalog2() throws Exception
	{
		/* TODO: crear un xml a mano y cargar el catálogo, 
		 * verificando que esté todo bien. */
		assertTrue(true);
	}
}
