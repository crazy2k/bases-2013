package ubadb.core.components.bufferManager.bufferPool.pools.multiple;

import java.util.LinkedList;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.components.bufferManager.bufferPool.BufferFrame;
import ubadb.core.components.bufferManager.bufferPool.BufferPool;
import ubadb.core.components.bufferManager.bufferPool.BufferPoolException;
/**
 * BufferPool that delegate buffering to multiple buffers.
 */
public class MultipleBufferPool implements BufferPool 
{
	private LinkedList<BufferPoolAssignment> bufferPoolAssignments;

	public MultipleBufferPool() 
	{		
		this.bufferPoolAssignments = new LinkedList<BufferPoolAssignment>();
	}

	@Override
	public boolean isPageInPool(PageId pageId) 
	{
		try 
		{
			return bufferPoolFor(pageId).isPageInPool(pageId);
		} 
		catch (BufferPoolException e) 
		{
			return false;
		}
	}

	@Override
	public BufferFrame getBufferFrame(PageId pageId) throws BufferPoolException 
	{
		return bufferPoolFor(pageId).getBufferFrame(pageId);
	}

	@Override
	public boolean hasSpace(PageId pageToAddId) 
	{
		try 
		{
			return bufferPoolFor(pageToAddId).hasSpace(pageToAddId);
		} 
		catch (BufferPoolException e) 
		{
			return false;
		}
	}

	@Override
	public BufferFrame addNewPage(Page page) throws BufferPoolException 
	{
		return bufferPoolFor(page.getPageId()).addNewPage(page);
	}

	@Override
	public void removePage(PageId pageId) throws BufferPoolException 
	{
		bufferPoolFor(pageId).removePage(pageId);
	}

	@Override
	public BufferFrame findVictim(PageId pageIdToBeAdded) throws BufferPoolException 
	{
		return bufferPoolFor(pageIdToBeAdded).findVictim(pageIdToBeAdded);
	}

	@Override
	public int countPagesInPool() 
	{
		int pagesInPool = 0;
		
		for(BufferPoolAssignment assignment : bufferPoolAssignments) 
		{
			pagesInPool += assignment.getBufferPool().countPagesInPool();
		}
		
		return pagesInPool;
	}

	public boolean multiplePoolsAreDefined() 
	{
		return false;
	}

	private BufferPool bufferPoolFor(PageId pageId) throws BufferPoolException 
	{							
		for(BufferPoolAssignment bufferPoolAssignment : this.bufferPoolAssignments)
		{
			if (bufferPoolAssignment.canHandle(pageId)) 
				return bufferPoolAssignment.getBufferPool();
		}
		
		throw new BufferPoolException("There are no buffer pool assignment for the provided pageId");
	}
	
	public void assignPool(BufferPoolAssignment bufferPoolAssignment) 
	{
		bufferPoolAssignments.addFirst(bufferPoolAssignment);		
	}

	public boolean hasPoolAssigned(PageId pageId) 
	{		
		for(BufferPoolAssignment bufferPoolAssignment : this.bufferPoolAssignments)
		{
			if (bufferPoolAssignment.canHandle(pageId)) 
				return true;
		}
		
		return false;
	}

}