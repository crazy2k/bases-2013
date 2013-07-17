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
		
		runBNLJTraces(pageReplacementStrategy);
		//runFileScanTraces(pageReplacementStrategy);
		//runIndexScanTraces(pageReplacementStrategy);		
		//runOurTraces(pageReplacementStrategy);
	}
	
	@SuppressWarnings("unused")
	private static void runBNLJTraces(PageReplacementStrategy pageReplacementStrategy)
	{
		List<String> traceFileNames = new LinkedList<String>();

		/* BNLJ */
		traceFileNames.add("generated/BNLJ-ProductXSale-group_50.trace");
		traceFileNames.add("generated/BNLJ-ProductXSale-group_75.trace");
		traceFileNames.add("generated/BNLJ-ProductXSale-group_100.trace"); // da memory full
		traceFileNames.add("generated/BNLJ-SaleXProduct-group_100.trace"); // da memory full
		traceFileNames.add("generated/BNLJ-SaleXProduct-group_250.trace"); // da memory full
		
		System.out.println("\nBNLJ\n");		
		runTraces(pageReplacementStrategy, traceFileNames);
	}
	
	@SuppressWarnings("unused")
	private static void runFileScanTraces(PageReplacementStrategy pageReplacementStrategy)
	{
		List<String> traceFileNames = new LinkedList<String>();
		
		/* File Scan. */			
		traceFileNames.add("generated/fileScan-Company.trace");
		traceFileNames.add("generated/fileScan-Product.trace");
		traceFileNames.add("generated/fileScan-Sale.trace");
		
		System.out.println("\nFile Scan\n");		
		runTraces(pageReplacementStrategy, traceFileNames);
	}
	
	@SuppressWarnings("unused")
	private static void runIndexScanTraces(PageReplacementStrategy pageReplacementStrategy)
	{
		List<String> traceFileNames = new LinkedList<String>();
		
		/* Index Scan. */
		traceFileNames.add("generated/indexScanClustered-Product.trace");
		traceFileNames.add("generated/indexScanClustered-Sale.trace");
		traceFileNames.add("generated/indexScanUnclustered-Product.trace");
		traceFileNames.add("generated/indexScanUnclustered-Sale.trace");
		
		System.out.println("\nIndex Scan\n");		
		runTraces(pageReplacementStrategy, traceFileNames);
	}
	
	@SuppressWarnings("unused")
	private static void runOurTraces(PageReplacementStrategy pageReplacementStrategy)
	{
		List<String> traceFileNames = new LinkedList<String>();
		
		/* Index Scan. */
		traceFileNames.add("generated/random0.trace");
		traceFileNames.add("generated/random1.trace");
		
		System.out.println("\nRandom Scan\n");		
		runTraces(pageReplacementStrategy, traceFileNames);
	}
	
	private static void runTraces(PageReplacementStrategy pageReplacementStrategy, List<String> traceFileNames)
	{
		for (String traceFileName: traceFileNames)
		{
			try
			{				
				System.out.println("\nTrace: " + traceFileName);
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
		/* Para BNLJ. */ 
		int sizes[] = {252, 300, 500, 700}; 
		//int sizes[] = {15, 20, 60, 120, 252, 300, 500, 700}; // 5 10 20 40 
		System.out.println("\nSingleBufferPool\n");
		
		for (int size : sizes)
		{
			//System.out.print("BufferSize: " + size + " ");
			System.out.print(size + " ");
			MainEvaluator.evaluateSingle(pageReplacementStrategy, traceFileName, size);			
		}
	}
	
	private static void evaluateWithMultiple(PageReplacementStrategy pageReplacementStrategy, String traceFileName) throws InterruptedException, BufferManagerException, Exception
	{	
		System.out.println("\nMultipleBufferPool\n");
		
		//for (int i = 0; i < 8; i++)
		for (int i = 4; i < 8; i++)
		{
			String filename = "catalogs/catalogSize" + i + ".xml";
			CatalogManager catalogManager = new CatalogManagerImpl("", filename);
			catalogManager.loadCatalog();
			
			Catalog catalog = catalogManager.catalog();
			//System.out.print("BufferSizes " + catalog.listPoolDescriptors() + " ");
			//System.out.print(catalog.listPoolDescriptors() + " ");
			MainEvaluator.evaluateMultiple(pageReplacementStrategy, traceFileName, catalogManager);
		}
	}
	
}
