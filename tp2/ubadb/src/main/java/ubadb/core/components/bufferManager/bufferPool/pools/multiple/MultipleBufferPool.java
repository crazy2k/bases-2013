package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.BufferPoolException;
import ubadb.core.components.bufferManager.bufferPool.pools.single.SingleBufferPool;
import ubadb.core.components.catalogManager.Catalog;
import ubadb.core.components.catalogManager.TableDescriptor;

public class MultipleBufferPool implements BufferPool
{
	private Map<TableId, SingleBufferPool> tableMap;

	public MultipleBufferPool()
	{
		
	}
	
	public MultipleBufferPool(Map<TableId, SingleBufferPool> tableMap)
	{
		this.tableMap = tableMap;
	}
	
	public MultipleBufferPool(Catalog c)
	{
		tableMap = new HashMap<TableId, SingleBufferPool>();
		List<TableDescriptor> tableDescriptors = c.getTableDescriptors();
		
		for (TableDescriptor t:tableDescriptors)
		{
			tableMap.put(t.getTableId(), t.getTableBuffer());
		}
	}

	public boolean isPageInPool(PageId pageId)
	{
		return tableMap.get(pageId.getTableId()).isPageInPool(pageId);
	}
	
	public BufferFrame getBufferFrame(PageId pageId) throws BufferPoolException
	{
		return getPoolBufferFor(pageId.getTableId()).getBufferFrame(pageId);
	}
	
	public boolean hasSpace(PageId pageToAddId)
	{
		try
		{
			return getPoolBufferFor(pageToAddId.getTableId()).hasSpace(pageToAddId);
		}
		catch (BufferPoolException e)
		{
			e.printStackTrace();
			return false;
		}
	}

	public BufferFrame addNewPage(Page page) throws BufferPoolException
	{
		return getPoolBufferFor(page.getPageId().getTableId()).addNewPage(page);
	}

	public void removePage(PageId pageId) throws BufferPoolException
	{
		getPoolBufferFor(pageId.getTableId()).removePage(pageId);
	}

	public BufferFrame findVictim(PageId pageIdToBeAdded) throws BufferPoolException
	{
		return getPoolBufferFor(pageIdToBeAdded.getTableId()).findVictim(pageIdToBeAdded);
	}

	public int countPagesInPool()
	{
		int result = 0;
		
		for (SingleBufferPool buffer : tableMap.values())
		{
			result += buffer.countPagesInPool();
		}
		
		return result;
	}
	
	private SingleBufferPool getPoolBufferFor(TableId tableId) throws BufferPoolException 
	{
		SingleBufferPool result = tableMap.get(tableId);
		
		if (result != null)
			return result;
		
		throw new BufferPoolException("The table is not being managed by the pool");
	}
}
