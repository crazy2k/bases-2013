package ubadb.core.testDoubles;

import java.util.LinkedList;
import java.util.List;

import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.pools.PoolDescriptor;
import ubadb.core.components.catalogManager.Catalog;
import ubadb.core.components.catalogManager.TableDescriptor;

public class SampleCatalog
{			
	private Catalog catalog;
	
	private TableDescriptor td0 = new TableDescriptor(new TableId("0"), "Table0", "./Table0", "Default");
	private TableDescriptor td1 = new TableDescriptor(new TableId("1"), "Table1", "./Table1", "Default");
	private TableDescriptor td2 = new TableDescriptor(new TableId("2"), "Table2", "./Table2", "Recycle");
	private TableDescriptor td3 = new TableDescriptor(new TableId("3"), "Table3", "./Table3", "Keep");
	private TableDescriptor td4 = new TableDescriptor(new TableId("4"), "Table4", "./Table4", "Keep");
	private TableDescriptor td5 = new TableDescriptor(new TableId("5"), "Table5", "./Table5", "Keep");
	
	private List<TableDescriptor> tableDescriptors = new LinkedList<TableDescriptor>();
	private List<PoolDescriptor> poolDescriptors = new LinkedList<PoolDescriptor>();
	
	private Integer DEFAULT_SIZE = 1;
	private Integer KEEP_SIZE = 2;
	private Integer RECYCLE_SIZE = 2;
	
	private void FakeCatalogInit()
	{
		tableDescriptors.add(td0);
		tableDescriptors.add(td1);
		tableDescriptors.add(td2);
		tableDescriptors.add(td3);
		tableDescriptors.add(td4);
		tableDescriptors.add(td5);
		
		poolDescriptors.add(new PoolDescriptor("Default", DEFAULT_SIZE));
		poolDescriptors.add(new PoolDescriptor("Keep", KEEP_SIZE));
		poolDescriptors.add(new PoolDescriptor("Recycle", RECYCLE_SIZE));
		
		catalog = new Catalog(tableDescriptors, poolDescriptors);
	}
	
	public SampleCatalog()
	{		
	}
	
	public Catalog getCatalog()
	{		
		this.FakeCatalogInit();
		return this.catalog;
	}
}
