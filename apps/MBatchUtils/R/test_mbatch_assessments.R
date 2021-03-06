#MBatchUtils Copyright ? 2018 University of Texas MD Anderson Cancer Center
#
#This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

library(MBatch)

#SupervisedClustering_Batches_Structures(theData, theTitle, theOutputPath, theDoHeatmapFlag)
#SupervisedClustering_Pairs_Structures(theData, theTitle, theOutputPath, theDoHeatmapFlag, theListOfBatchPairs)
# theListOfBatchPairs=c("PlateId", "TSS", "BatchId", "TSS")
#PCA_Regular_Structures(theData, theTitle, theOutputPath, theBatchTypeAndValuePairsToRemove, theBatchTypeAndValuePairsToKeep, theIsPcaTrendFunction=NULL, theDoCentroidsMtoMFlag=TRUE, theDoPlainMtoMFlag=FALSE, theDoCentroidsOtoMFlag=FALSE, theDoPlainOtoMFlag=FALSE, theDoDSCFlag=TRUE, theDoDscPermsFileFlag=FALSE, theDoSampleLocatorFlag=TRUE, theListOfComponentsToPlot=c(1, 2, 1, 3, 1, 4, 2, 3, 2, 4, 3, 4), theDSCPermutations=2000, theDSCThreads=1, theMinBatchSize=2, theJavaParameters="-Xms1200m", theSeed=0, theMaxGeneCount=20000)
#PCA_DualBatch_Structures(theData, theTitle, theOutputPath, theBatchTypeAndValuePairsToRemove, theBatchTypeAndValuePairsToKeep, theListForDoCentroidDualBatchType, theIsPcaTrendFunction=NULL, theDoDSCFlag=TRUE, theDoDscPermsFileFlag=FALSE, theDoSampleLocatorFlag=TRUE, theListOfComponentsToPlot=c(1, 2, 1, 3, 1, 4, 2, 3, 2, 4, 3, 4), theDSCPermutations=2000, theDSCThreads=1, theMinBatchSize=2, theJavaParameters="-Xms1200m", theSeed=0, theMaxGeneCount=20000)
#Boxplot_Group_Structures(theData, theTitle, theOutputPath, theBatchTypeAndValuePairsToRemove, theBatchTypeAndValuePairsToKeep, theListOfGroupBoxFunction, theListOfGroupBoxLabels)
#Boxplot_AllSamplesRLE_Structures(theData, theTitle, theOutputPath, theBatchTypeAndValuePairsToRemove, theBatchTypeAndValuePairsToKeep)
#Boxplot_Group_Structures(theData, theTitle, theOutputPath, theBatchTypeAndValuePairsToRemove, theBatchTypeAndValuePairsToKeep, theListOfGroupBoxFunction, theListOfGroupBoxLabels)

loadDataManually <- function(theGeneFile, theBatchFile)
{
	# this reads files into a matrix (for the gene data) and a data frame (for the batch information)
	# as an example of how to get the MBatch object from mbatchLoadStructures, which is used as an argument to the other MBatch functions
	geneMatrix <- read.csv(theGeneFile, header=TRUE, sep="\t", as.is=TRUE, check.names=FALSE, stringsAsFactors=FALSE, row.names=1)
	geneMatrix <- as.matrix(geneMatrix)
	batchDataframe <- read.csv(theBatchFile, header=TRUE, sep="\t", as.is=TRUE, check.names=FALSE, stringsAsFactors=FALSE, colClasses="character")
	mbatchLoadStructures(geneMatrix, batchDataframe)
}

################################################################################
################################################################################
################################################################################
################################################################################

callMBatch_HierarchicalClustering <- function(theOutputDir, theGeneFile, theBatchFile, theTitle)
{
  # load data
  myData <- loadDataManually(theGeneFile, theBatchFile)
  callMBatch_HierarchicalClustering_Structures(theOutputDir, myData, theTitle)
}

callMBatch_HierarchicalClustering_Structures <- function(theOutputDir, theDataObject, theTitle)
{
  # output directory
	outdir <- file.path(theOutputDir, "HierarchicalClustering")
	dir.create(outdir, showWarnings=FALSE, recursive=TRUE)
	# here, we take all the defaults to hierarchical clustering, passing a title and an output path
	HierarchicalClustering_Structures(theData=theDataObject,
									theTitle=theTitle,
									theOutputPath=outdir)
}

################################################################################
################################################################################
################################################################################
################################################################################

callMBatch_SupervisedClustering <- function(theOutputDir, theGeneFile, theBatchFile, theTitle)
{
  myData <- loadDataManually(theGeneFile, theBatchFile)
  callMBatch_SupervisedClustering_Structures(theOutputDir, myData, theTitle)
}

callMBatch_SupervisedClustering_Structures <- function(theOutputDir, theDataObject, theTitle)
{
  # output directory
	outdir <- file.path(theOutputDir, "SupervisedClustering")
	dir.create(outdir, showWarnings=FALSE, recursive=TRUE)
	# here, we call supervised clustering, passing a title and an output path,
	# telling it to generate a heatmap and to use the data without removing any type/values
	# and keeping any other defaults
	SupervisedClustering_Batches_Structures(theData=theDataObject,
									theTitle=theTitle,
									theOutputPath=outdir,
									theDoHeatmapFlag=TRUE,
									theBatchTypeAndValuePairsToRemove=NULL,
									theBatchTypeAndValuePairsToKeep=NULL)
}

################################################################################
################################################################################
################################################################################
################################################################################

callMBatch_SupervisedClusteringPairs <- function(theOutputDir, theGeneFile, theBatchFile, theTitle)
{
  # load data
  myData <- loadDataManually(theGeneFile, theBatchFile)
  callMBatch_SupervisedClusteringPairs_Structures(theOutputDir, myData, theTitle)
}

callMBatch_SupervisedClusteringPairs_Structures <- function(theOutputDir, theDataObject, theTitle)
{
  # output directory
	outdir <- file.path(theOutputDir, "SupervisedClusteringPairs")
	dir.create(outdir, showWarnings=FALSE, recursive=TRUE)
	# here, we call supervised clustering pairs, passing a title and an output path,
	# telling it to generate a heatmap and tell it we want the BatchId and PlateId data paired and the TSS and ShipDate data paired
	# and to use the data without removing any type/values
	# and keeping any other defaults
	SupervisedClustering_Pairs_Structures(theData=theDataObject,
									theTitle=theTitle,
									theOutputPath=outdir,
									theDoHeatmapFlag=TRUE,
									theListOfBatchPairs=c("BatchId", "PlateId", "TSS", "ShipDate"),
									theBatchTypeAndValuePairsToRemove=NULL,
									theBatchTypeAndValuePairsToKeep=NULL)
}

################################################################################
################################################################################
################################################################################
################################################################################

isTrendBatch<-function(theBatchTypeName, theListOfBatchIds)
{
  return(is.element(theBatchTypeName, c("ShipDate")))
}

callMBatch_PCA <- function(theOutputDir, theGeneFile, theBatchFile, theTitle, aTest=TRUE)
{
  # load data
  myData <- loadDataManually(theGeneFile, theBatchFile)
  callMBatch_PCA_Structures(theOutputDir, myData, theTitle, isTrendBatch)
  if(TRUE==aTest)
  {
    buildDSCOverviewFile(file.path(theOutputDir, "PCA"), "DSCOverview.tsv")
    clearDSCOverviewFiles(file.path(theOutputDir, "PCA"))
  }
}

callMBatch_PCA_Structures <- function(theOutputDir, theDataObject, theTitle,
                                      theIsPcaTrendFunction,
                                      theDSCPermutations=1000,
                                      theDSCThreads=1,
                                      theMinBatchSize=2,
                                      theJavaParameters="-Xms2000m",
                                      theSeed=314,
                                      theMaxGeneCount=10000)
{
  # output directory
	outdir <- file.path(theOutputDir, "PCA")
	dir.create(outdir, showWarnings=FALSE, recursive=TRUE)
	# here, we call PCA, passing a title and an output path,
	# and to use the data without removing any type/values
	# and keeping any other defaults
	PCA_Regular_Structures(theData=theDataObject,
							theTitle=theTitle,
							theOutputPath=outdir,
							theBatchTypeAndValuePairsToRemove=NULL,
							theBatchTypeAndValuePairsToKeep=NULL,
							theDoDscPermsFileFlag = TRUE,
							theIsPcaTrendFunction=theIsPcaTrendFunction,
							theDSCPermutations=theDSCPermutations,
							theDSCThreads=theDSCThreads,
							theMinBatchSize=theMinBatchSize,
							theJavaParameters=theJavaParameters,
							theSeed=theSeed,
							theMaxGeneCount=theMaxGeneCount)
}

################################################################################
################################################################################
################################################################################
################################################################################

callMBatch_PCADualBatch <- function(theOutputDir, theGeneFile, theBatchFile, theTitle, aTest=TRUE)
{
  myData <- loadDataManually(theGeneFile, theBatchFile)
  callMBatch_PCADualBatch_Structures(theOutputDir, myData, theTitle, isTrendBatch)
  if(TRUE==aTest)
  {
    buildDSCOverviewFile(file.path(theOutputDir, "PCADualBatch"), "DSCOverview.tsv")
    clearDSCOverviewFiles(file.path(theOutputDir, "PCADualBatch"))
  }
}

callMBatch_PCADualBatch_Structures <- function(theOutputDir, theDataObject, theTitle,
                                               theIsPcaTrendFunction,
                                               theDSCPermutations=1000,
                                               theDSCThreads=1,
                                               theMinBatchSize=2,
                                               theJavaParameters="-Xms2000m",
                                               theSeed=314,
                                               theMaxGeneCount=10000)
{
  # output directory
	outdir <- file.path(theOutputDir, "PCADualBatch")
	dir.create(outdir, showWarnings=FALSE, recursive=TRUE)
	# here, we call PCA dual batch, passing a title and an output path,
	# and to use the data without removing any type/values
	# and tell it we want the BatchId and PlateId data paired and the TSS and ShipDate data paired
	# and keeping any other defaults
	PCA_DualBatch_Structures(theData=theDataObject,
							theTitle=theTitle,
							theOutputPath=outdir,
							theBatchTypeAndValuePairsToRemove=NULL,
							theBatchTypeAndValuePairsToKeep=NULL,
							theListForDoCentroidDualBatchType=c("BatchId", "PlateId", "TSS", "ShipDate"),
							theIsPcaTrendFunction=theIsPcaTrendFunction,
							theDSCPermutations=theDSCPermutations,
							theDSCThreads=theDSCThreads,
							theMinBatchSize=theMinBatchSize,
							theJavaParameters=theJavaParameters,
							theSeed=theSeed,
							theMaxGeneCount=theMaxGeneCount)
}

################################################################################
################################################################################
################################################################################
################################################################################

callMBatch_BoxplotAllSamplesData <- function(theOutputDir, theGeneFile, theBatchFile, theTitle,
                                             theJavaParameters=c("-Xms8000m", "-Djava.awt.headless=true"), theMaxGeneCount = 10000)
{
  # load data
  myData <- loadDataManually(theGeneFile, theBatchFile)
  callMBatch_BoxplotAllSamplesData_Structures(theOutputDir, myData, theTitle, theJavaParameters, theMaxGeneCount)
}

callMBatch_BoxplotAllSamplesData_Structures <- function(theOutputDir, theDataObject, theTitle,
                                                        theJavaParameters=c("-Xms8000m", "-Djava.awt.headless=true"), theMaxGeneCount = 10000)
{
  # output directory
	outdir <- file.path(theOutputDir, "BoxPlot")
	dir.create(outdir, showWarnings=FALSE, recursive=TRUE)
	# here, we call boxplot all samples data, passing a title and an output path,
	# and to use the data without removing any type/values
	# and tell it to use 8G of memory
	# and keeping any other defaults
	Boxplot_AllSamplesData_Structures(theData=theDataObject,
							theTitle=theTitle,
							theOutputPath=outdir,
							theBatchTypeAndValuePairsToRemove=NULL,
							theBatchTypeAndValuePairsToKeep=NULL,
							theJavaParameters=theJavaParameters,
							theMaxGeneCount = theMaxGeneCount)
}

################################################################################
################################################################################
################################################################################
################################################################################

callMBatch_BoxplotAllSamplesRLE <- function(theOutputDir, theGeneFile, theBatchFile, theTitle,
                                            theJavaParameters=c("-Xms8000m", "-Djava.awt.headless=true"), theMaxGeneCount = 10000)
{
  # load data
  myData <- loadDataManually(theGeneFile, theBatchFile)
  callMBatch_BoxplotAllSamplesRLE_Structures(theOutputDir, myData, theTitle, theJavaParameters)
}

callMBatch_BoxplotAllSamplesRLE_Structures <- function(theOutputDir, theDataObject, theTitle,
                                                       theJavaParameters=c("-Xms8000m", "-Djava.awt.headless=true"), theMaxGeneCount = 10000)
{
	# output directory
  outdir <- file.path(theOutputDir, "BoxPlot")
	dir.create(outdir, showWarnings=FALSE, recursive=TRUE)
	# here, we call boxplot all samples RLE, passing a title and an output path,
	# and to use the data without removing any type/values
	# and tell it to use 8G of memory
	# and keeping any other defaults
	Boxplot_AllSamplesRLE_Structures(theData=theDataObject,
							theTitle=theTitle,
							theOutputPath=outdir,
							theBatchTypeAndValuePairsToRemove=NULL,
							theBatchTypeAndValuePairsToKeep=NULL,
							theJavaParameters=theJavaParameters,
							theMaxGeneCount=theMaxGeneCount)
}

################################################################################
################################################################################
################################################################################
################################################################################

callMBatch_BoxplotGroup <- function(theOutputDir, theGeneFile, theBatchFile, theTitle,
                                    theJavaParameters=c("-Xms8000m", "-Djava.awt.headless=true"), theMaxGeneCount = 10000,
                                    theFunction=c(mean), theFunctionName=c("Mean"))
{
  # load data
  myData <- loadDataManually(theGeneFile, theBatchFile)
  callMBatch_BoxplotGroup_Structures(theOutputDir, myData, theTitle,
                                     theJavaParameters, theMaxGeneCount,
                                     theFunction, theFunctionName)
}

callMBatch_BoxplotGroup_Structures <- function(theOutputDir, theDataObject, theTitle,
                                               theJavaParameters=c("-Xms8000m", "-Djava.awt.headless=true"), theMaxGeneCount = 10000,
                                               theFunction=c(mean), theFunctionName=c("Mean"))
{
	# output directory
  outdir <- file.path(theOutputDir, "BoxPlot")
	dir.create(outdir, showWarnings=FALSE, recursive=TRUE)
	# here, we call boxplot group, passing a title and an output path,
	# and to use the data without removing any type/values
	# and tu use the mean function and the label "mean"
	# and tell it to use 8G of memory
	# and keeping any other defaults
	Boxplot_Group_Structures(theData=theDataObject,
							theTitle=theTitle,
							theOutputPath=outdir,
							theBatchTypeAndValuePairsToRemove=NULL,
							theBatchTypeAndValuePairsToKeep=NULL,
							theListOfGroupBoxFunction=theFunction,
							theListOfGroupBoxLabels=theFunctionName,
							theJavaParameters=theJavaParameters,
							theMaxGeneCount=theMaxGeneCount)
}

################################################################################
################################################################################
################################################################################
################################################################################
