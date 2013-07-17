package ubadb.external.bufferManagement;

import java.util.LinkedList;
import java.util.List;

import ubadb.core.components.bufferManager.BufferManagerException;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.fifo.FIFOReplacementStrategy;
import ubadb.core.components.catalogManager.Catalog;
import ubadb.core.components.catalogManager.CatalogManager;
import ubadb.core.components.catalogManager.CatalogManagerImpl;

/* Usa single y multiple buffer pool */

public class TpEvaluator 
{	
	public static void main(String[] args)
	{
		PageReplacementStrategy pageReplacementStrategy = new FIFOReplacementStrategy();		
		List<String> traceFileNames = new LinkedList<String>();

		/* BNLJ */
		//traceFileNames.add("generated/BNLJ-ProductXSale-group_50.trace");
		//traceFileNames.add("generated/BNLJ-ProductXSale-group_75.trace");
		//traceFileNames.add("generated/BNLJ-ProductXSale-group_100.trace"); // da memory full
		//traceFileNames.add("generated/BNLJ-SaleXProduct-group_100.trace"); // da memory full
		//traceFileNames.add("generated/BNLJ-SaleXProduct-group_250.trace"); // da memory full
		
		/* File Scan. */			
		traceFileNames.add("generated/fileScan-Company.trace");
		//traceFileNames.add("generated/fileScan-Product.trace");
		//traceFileNames.add("generated/fileScan-Sale.trace");
		
		/* Index Scan. */
		//traceFileNames.add("generated/indexScanClustered-Product.trace");
		//traceFileNames.add("generated/indexScanClustered-Sale.trace");
		//traceFileNames.add("generated/indexScanUnclustered-Product.trace");
		//traceFileNames.add("generated/indexScanUnclustered-Sale.trace");
		
		for (String traceFileName: traceFileNames)
		{
			try
			{
				System.out.println("Trace: " + traceFileName);
				evaluateWithSingle(pageReplacementStrategy, traceFileName);
				evaluateWithMultiple(pageReplacementStrategy, traceFileName);
			}
			catch(Exception e)
			{
				System.out.println("FATAL ERROR (" + e.getMessage() + ")");
				e.printStackTrace();
			}
		}
	}
	
	private static void evaluateWithSingle(PageReplacementStrategy pageReplacementStrategy, String traceFileName) throws InterruptedException, BufferManagerException, Exception
	{
		int sizes[] = {5, 25, 50, 100};		
		System.out.println("SingleBufferPool");
		
		for (int size : sizes)
		{
			System.out.print("BufferSize: " + size + " ");
			MainEvaluator.evaluateSingle(pageReplacementStrategy, traceFileName, size);
		}
	}
	
	private static void evaluateWithMultiple(PageReplacementStrategy pageReplacementStrategy, String traceFileName) throws InterruptedException, BufferManagerException, Exception
	{	
		System.out.println("MultipleBufferPool");
		
		for (int i = 0; i < 1; i++)
		{
			String filename = "catalogs/catalogSize" + i + ".xml";
			CatalogManager catalogManager = new CatalogManagerImpl("", filename);
			catalogManager.loadCatalog();
			
			Catalog catalog = catalogManager.catalog();
			System.out.print("BufferSize: " + catalog.listPoolDescriptors() + " ");
			MainEvaluator.evaluateMultiple(pageReplacementStrategy, traceFileName, catalogManager);
		}
	}
	
}
