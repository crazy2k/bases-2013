package ubadb.core.components.catalogManager;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.util.LinkedList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.pools.PoolDescriptor;

public class CatalogTest 
{
	private Catalog catalog;	
	private TableDescriptor td1 = new TableDescriptor(new TableId("1"), "Table1", "./Table1");
	private TableDescriptor td2 = new TableDescriptor(new TableId("2"), "Table2", "./Table2");
	private TableDescriptor td3 = new TableDescriptor(new TableId("3"), "Table3", "./Table3");
	private Integer DEFAULT_SIZE = 500;
	private Integer KEEP_SIZE = 100;
	private Integer RECYCLE_SIZE = 50;
	
	@Before
	public void setUp()
	{
		List<TableDescriptor> tableDescriptors = new LinkedList<TableDescriptor>();
		tableDescriptors.add(td1);
		tableDescriptors.add(td2);
		tableDescriptors.add(td3);
		
		List<PoolDescriptor> poolDescriptors = new LinkedList<PoolDescriptor>();
		poolDescriptors.add(new PoolDescriptor("Default", DEFAULT_SIZE));
		poolDescriptors.add(new PoolDescriptor("Keep", KEEP_SIZE));
		poolDescriptors.add(new PoolDescriptor("Recycle", RECYCLE_SIZE));
		
		catalog = new Catalog(tableDescriptors, poolDescriptors);
	}
	
	@Test
	public void testGetTableDescriptorByTableId()
	{
		TableDescriptor t = catalog.getTableDescriptorByTableId(new TableId("1"));
		assertEquals(t, td1);
		
		t = catalog.getTableDescriptorByTableId(new TableId("3"));
		assertEquals(t, td3);
		
		/* Este no está */
		t = catalog.getTableDescriptorByTableId(new TableId("5"));
		assertNull(t);
	}	
}