package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPoolException;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import ubadb.core.testDoubles.DummyObjectFactory;
import ubadb.core.testDoubles.FakePageReplacementStrategy;

public class MultipleBufferPoolTest 
{

	private MultipleBufferPool bufferPool;
	
	private static final int POOL_KEEP_SIZE = 6;
	private static final int POOL_RECYCLE_SIZE = 3;
	
	private SingleBufferPool defaultBuffer = DefaultBuffer.getDefaultBuffer();
	private SingleBufferPool keepBuffer;
	private SingleBufferPool recycleBuffer;
	
	private Page PAGE_0;
	private Page PAGE_1;
	private Page PAGE_2;
	private Page PAGE_3;
	private Page PAGE_4;
	private Page PAGE_5;
	
	private Page[] pages = new Page[6];
	
	@Before
	public void setUp()
	{
		keepBuffer = new SingleBufferPool(POOL_KEEP_SIZE, new FakePageReplacementStrategy());
		recycleBuffer = new SingleBufferPool(POOL_RECYCLE_SIZE, new FakePageReplacementStrategy());
		
		/* Poner esto si se usa una lista
		pages.add(PAGE_0);
		pages.add(PAGE_1);
		pages.add(PAGE_2);
		pages.add(PAGE_3);
		pages.add(PAGE_4);
		pages.add(PAGE_5);
		*/
		
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
