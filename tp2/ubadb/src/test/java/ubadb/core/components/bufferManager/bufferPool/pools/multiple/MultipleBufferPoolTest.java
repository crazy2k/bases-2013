package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPoolException;
import ubadb.core.components.catalogManager.Catalog;
import ubadb.core.components.catalogManager.TableDescriptor;
import ubadb.core.testDoubles.SampleCatalog;

public class MultipleBufferPoolTest 
{

	private MultipleBufferPool bufferPool;	
	private Catalog catalog;
	private List<Page> pages = new ArrayList<Page>(); 
	
	@Before
	public void setUp()
	{
		catalog = (new SampleCatalog().getCatalog());
		bufferPool = new MultipleBufferPool(catalog);
		
		List<TableDescriptor> tableDescriptors = catalog.getTableDescriptors();
		
		for (int i = 0; i < 6; i++)
		{			 
			PageId pageId = new PageId(i, tableDescriptors.get(i).getTableId());
			pages.add(new Page(pageId, "abd".getBytes()));
		}
	}
	
	@Test
	public void testIsPageInPoolTrue() throws Exception
	{
		bufferPool.addNewPage(pages.get(0));		
		assertTrue(bufferPool.isPageInPool(pages.get(0).getPageId()));
	}
	
	@Test
	public void testIsPageInPoolFalse() throws Exception
	{
		assertFalse(bufferPool.isPageInPool(pages.get(0).getPageId()));
	}
	
	@Test
	public void testGetExistingPage() throws Exception
	{
		BufferFrame expectedFrame = bufferPool.addNewPage(pages.get(0));
		
		assertEquals(expectedFrame, bufferPool.getBufferFrame(pages.get(0).getPageId()));
	}
	
	@Test(expected=BufferPoolException.class)
	public void testGetUnexistingPage() throws Exception
	{
		bufferPool.addNewPage(pages.get(0));
		
		assertNull(bufferPool.getBufferFrame(new PageId(99, new TableId("bbbb"))));
	}
	
	@Test
	public void testHasSpaceTrue() throws Exception
	{
		bufferPool.addNewPage(pages.get(3));
		assertTrue(bufferPool.hasSpace(pages.get(4).getPageId()));
	}
	
	@Test
	public void testHasSpaceFalse() throws Exception
	{
		/* Keep */
		bufferPool.addNewPage(pages.get(3));
		bufferPool.addNewPage(pages.get(4));
		
		assertFalse(bufferPool.hasSpace(pages.get(5).getPageId()));
	}
		
	@Test
	public void testAddNewPageWithSpace() throws Exception
	{
		bufferPool.addNewPage(pages.get(0));
		bufferPool.addNewPage(pages.get(3));
		
		assertEquals(2, bufferPool.countPagesInPool());
	}	
	
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithoutSpace() throws Exception
	{
		bufferPool.addNewPage(pages.get(2));
		bufferPool.addNewPage(pages.get(3));
		bufferPool.addNewPage(pages.get(4));
		bufferPool.addNewPage(pages.get(5));
	}
	
	@Test(expected=BufferPoolException.class)
	public void testAddNewPageWithExisting() throws Exception
	{
		bufferPool.addNewPage(pages.get(0));
		bufferPool.addNewPage(pages.get(0));
	}
	
	@Test
	public void testNewPageIsUnpinnedAndNotDirtyByDefault() throws Exception
	{
		BufferFrame bufferFrame = bufferPool.addNewPage(pages.get(0));

		assertEquals(0, bufferFrame.getPinCount());
		assertFalse(bufferFrame.isDirty());
	}
	
	@Test
	public void testRemoveExistingPage() throws Exception
	{
		bufferPool.addNewPage(pages.get(0));
		bufferPool.addNewPage(pages.get(2));
		bufferPool.addNewPage(pages.get(3));
		
		bufferPool.removePage(pages.get(0).getPageId());
		
		assertFalse(bufferPool.isPageInPool(pages.get(0).getPageId()));
	}
	
	@Test(expected=BufferPoolException.class)
	public void testRemoveUnexistingPage() throws Exception
	{
		bufferPool.addNewPage(pages.get(0));
		bufferPool.addNewPage(pages.get(2));
		bufferPool.addNewPage(pages.get(3));
		
		bufferPool.removePage(pages.get(4).getPageId());
	}
	
	@Test
	public void countPagesEmptyPool()
	{
		assertEquals(0, bufferPool.countPagesInPool());
	}
	
	@Test
	public void countPagesNonEmptyPool() throws Exception
	{
		bufferPool.addNewPage(pages.get(0));
		bufferPool.addNewPage(pages.get(2));
		bufferPool.addNewPage(pages.get(3));
		
		assertEquals(3, bufferPool.countPagesInPool());		
	}
	
}
