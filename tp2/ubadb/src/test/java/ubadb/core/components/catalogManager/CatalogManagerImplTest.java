package ubadb.core.components.catalogManager;

import static org.junit.Assert.assertEquals;

import java.io.FileOutputStream;
import java.util.LinkedList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.common.TableId;
import ubadb.core.util.xml.XmlUtil;
import ubadb.core.util.xml.XstreamXmlUtil;

import com.thoughtworks.xstream.XStream;


public class CatalogManagerImplTest {
	
	private Catalog catalog;
	private TableDescriptor td1 = new TableDescriptor(new TableId("1"), "Table1", "Table1");
	private TableDescriptor td2 = new TableDescriptor(new TableId("2"), "Table2", "Table2");
	private TableDescriptor td3 = new TableDescriptor(new TableId("3"), "Table3", "Table3");
	
	@Before
	public void setUp()
	{
	
		List<TableDescriptor> tds = new LinkedList<TableDescriptor>();
		tds.add(td1);
		tds.add(td2);
		tds.add(td3);
		
		catalog = new Catalog(tds);
	}
	
	@Test
	public void testLoadCatalog() throws Exception
	{
		XStream xstream = new XStream();
		//XmlUtil xml = new XstreamXmlUtil(xstream);	
		String filename = "catalogTestFile";
		xstream.toXML(catalog, new FileOutputStream(filename));
		
		CatalogManager cm = new CatalogManagerImpl("", filename);
		cm.loadCatalog();
		assertEquals(cm.getTableDescriptorByTableId(new TableId("1")), td1);
	}
}
