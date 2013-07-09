package ubadb.core.components.catalogManager;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.util.List;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.common.TableId;
import ubadb.core.testDoubles.SampleCatalog;

public class CatalogTest 
{
	private Catalog catalog;
	private List<TableDescriptor> tableDescriptors;
	
	@Before
	public void setUp()
	{		
		SampleCatalog f = new SampleCatalog();
		
		catalog = (f.getCatalog());
		this.tableDescriptors = f.getTableDescriptors(); 
	}
	
	@Test
	public void testGetTableDescriptorByTableId()
	{
		TableDescriptor t = catalog.getTableDescriptorByTableId(new TableId("0"));
		assertEquals(t, this.tableDescriptors.get(0));
		
		t = catalog.getTableDescriptorByTableId(new TableId("3"));
		assertEquals(t, this.tableDescriptors.get(3));
		
		/* Este no está */
		t = catalog.getTableDescriptorByTableId(new TableId("6"));
		assertNull(t);
	}	
}