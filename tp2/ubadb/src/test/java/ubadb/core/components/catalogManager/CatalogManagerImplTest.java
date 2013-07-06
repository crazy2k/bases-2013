package ubadb.core.components.catalogManager;

//import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.io.FileOutputStream;
import java.util.LinkedList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.common.TableId;
import com.thoughtworks.xstream.XStream;

public class CatalogManagerImplTest 
{	
	private Catalog catalog;
	private TableDescriptor td1 = new TableDescriptor(new TableId("1"), "Table1", "./Table1");
	private TableDescriptor td2 = new TableDescriptor(new TableId("2"), "Table2", "./Table2");
	private TableDescriptor td3 = new TableDescriptor(new TableId("3"), "Table3", "./Table3");
	
	@Before
	public void setUp()
	{
	
		List<TableDescriptor> tableDescriptors = new LinkedList<TableDescriptor>();
		tableDescriptors.add(td1);
		tableDescriptors.add(td2);
		tableDescriptors.add(td3);
		
		catalog = new Catalog(tableDescriptors);
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
	}
}
