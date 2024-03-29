package ubadb.core.common;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

import ubadb.core.common.Page;
import ubadb.core.common.PageId;
import ubadb.core.common.TableId;

public class PageTest
{
	@Test
	public void equalsTrueSameObject()
	{
		Page page1 = new Page(new PageId(1, new TableId("a")), new byte[]{1,1,1,1});
		assertTrue(page1.equals(page1));
	}
	
	@Test
	public void equalsTrueOtherObject()
	{
		Page page1 = new Page(new PageId(1, new TableId("a")), new byte[]{1,1,1,1});
		Page page2 = new Page(new PageId(1, new TableId("a")), new byte[]{1,1,1,1});
		
		assertTrue(page1.equals(page2));
		assertEquals(page1.hashCode(),page2.hashCode());
	}
	
	@Test
	public void equalsFalseNullObject()
	{
		Page page1 = new Page(new PageId(1, new TableId("a")), new byte[]{1,1,1,1});
		assertFalse(page1.equals(null));
	}
	
	@Test
	public void equalsFalseDifferentType()
	{
		Page page1 = new Page(new PageId(1, new TableId("a")), new byte[]{1,1,1,1});
		assertFalse(page1.equals("aaaaaaaaaaaaaaaaaa"));
	}
	
	@Test
	public void equalsFalseDifferentPageId()
	{
		Page page1 = new Page(new PageId(1, new TableId("a")), new byte[]{1,1,1,1});
		Page page2 = new Page(new PageId(2, new TableId("bbbbb")), new byte[]{1,1,1,1});
		assertFalse(page1.equals(page2));
	}
	
	@Test
	public void equalsFalseDifferentPageContents()
	{
		Page page1 = new Page(new PageId(1, new TableId("a")), new byte[]{1,1,1,1});
		Page page2 = new Page(new PageId(1, new TableId("a")), new byte[]{2,2,2,2,2,2,2,2,2,2});
		assertFalse(page1.equals(page2));
	}
}
