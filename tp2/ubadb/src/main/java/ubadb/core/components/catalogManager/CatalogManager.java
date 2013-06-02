package ubadb.core.components.catalogManager;

import ubadb.core.common.TableId;
import ubadb.core.util.xml.XmlUtilException;

public interface CatalogManager
{
	void loadCatalog() throws CatalogManagerException, XmlUtilException;
	TableDescriptor getTableDescriptorByTableId(TableId tableId);
}