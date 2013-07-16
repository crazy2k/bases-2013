package ubadb.external.bufferManagement;

import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.PageReplacementStrategy;
import ubadb.core.components.bufferManager.bufferPool.replacementStrategies.fifo.FIFOReplacementStrategy;

/* Usa single y multiple buffer pool */

public class TpEvaluator 
{	
	public static void main(String[] args)
	{
		try
		{
			PageReplacementStrategy pageReplacementStrategy = new FIFOReplacementStrategy();

			/* BNLJ */
			//String traceFileName = "generated/BNLJ-ProductXSale-group_50.trace";
			//String traceFileName = "generated/BNLJ-ProductXSale-group_75.trace";
			//String traceFileName = "generated/BNLJ-ProductXSale-group_100.trace"; // da memory full
			//String traceFileName = "generated/BNLJ-SaleXProduct-group_100.trace"; // da memory full
			//String traceFileName = "generated/BNLJ-SaleXProduct-group_250.trace"; // da memory full
			
			/* File Scan. */			
			String traceFileName = "generated/fileScan-Company.trace";
			//String traceFileName = "generated/fileScan-Product.trace";
			//String traceFileName = "generated/fileScan-Sale.trace";
			
			/* Index Scan. */
			//String traceFileName = "generated/indexScanClustered-Product.trace";
			//String traceFileName = "generated/indexScanClustered-Sale.trace";
			//String traceFileName = "generated/indexScanUnclustered-Product.trace";
			//String traceFileName = "generated/indexScanUnclustered-Sale.trace";
			
			MainEvaluator.evaluateSingle(pageReplacementStrategy, traceFileName, 100);
		}
		catch(Exception e)
		{
			System.out.println("FATAL ERROR (" + e.getMessage() + ")");
			e.printStackTrace();
		}
	}
}
