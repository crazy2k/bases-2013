package src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import src.main.java.ubadb.core.components.bufferManager.bufferPool.pools.multiple.TableId;
import src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.single.Before;
import src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.single.Exception;
import src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.single.FakePageReplacementStrategy;
import src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.single.Page;
import src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.single.PageId;
import src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.single.MultipleBufferPool;
import src.test.java.ubadb.core.components.bufferManager.bufferPool.pools.single.Test;

public class MultipleBufferPoolTest 
{

	private MultipleBufferPool bufferPool;
	
	private static final int POOL_KEEP_SIZE = 6;
	private static final int POOL_RECYCLE_SIZE = 3;
	
	private static final SingleBufferPool defaultBuffer = DefaultBuffer.getDefaultBuffer();
	private static final SingleBufferPool keepBuffer;
	private static final SingleBufferPool recycleBuffer;
	
	private static final Page PAGE_0;
	private static final Page PAGE_1;
	private static final Page PAGE_2;
	private static final Page PAGE_3;
	private static final Page PAGE_4;
	private static final Page PAGE_5;
	
	private static final List<Page> pages = new LinkedList<Page>();
	
	@Before
	public void setUp()
	{
		keepBuffer = new SingleBufferPool(POOL_KEEP_SIZE, new FakePageReplacementStrategy());
		recycleBuffer = new SingleBufferPool(POOL_RECYCLE_SIZE, new FakePageReplacementStrategy());
		
		pages.add(PAGE_0);
		pages.add(PAGE_1);
		pages.add(PAGE_2);
		pages.add(PAGE_3);
		pages.add(PAGE_4);
		pages.add(PAGE_5);
		
		for (int i = 0; i < 6; i++)
		{
			pages[i] = new Page(new PageId(i, DummyObjectFactory.TABLE_ID), "abc".getBytes());
		}
		
		Map<TableId, SingleBufferPool> tableMap = new HashMap<TableId, SingleBufferPool>();
		
		/* Generate Map */
		
		for (Page page : pages)
		{
			tableMap.put(page.getPageId().getTableId(), defaultBuffer);
		}
		
		tableMap.put(pages[2].getPageId().getTableId(), keepBuffer);
		tableMap.put(pages[3].getPageId().getTableId(), keepBuffer);
		
		tableMap.put(pages[5].getPageId().getTableId(), recycleBuffer);
		
		bufferPool = new MultipleBufferPool(tableMap);
	}
	
	@Test
	public void testIsPageInPoolTrue() throws Exception
	{
		
	}
	
}
